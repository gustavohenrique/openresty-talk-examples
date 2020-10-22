local headers = ngx.req.get_headers()
local authorization = headers["Authorization"]
if not authorization then
    ngx.say("The request header was not found.")
    ngx.exit(401)
end
local token = string.sub(authorization, 8)
if not token or token == "" then
    ngx.say("Invalid token. ", token)
    ngx.exit(403)
end

local jwt = require "resty.jwt"
local validators = require "resty.jwt-validators"
local claim_spec = {
    exp = validators.is_not_expired(),
    iss = validators.equals_any_of({ ngx.var.jwt_issuer })
}
local jwt_obj = jwt:verify(ngx.var.jwt_secret, token, claim_spec)
if not jwt_obj.verified then
    ngx.say("Authentication failed. ")
    ngx.exit(403)
end

local payload = jwt_obj.payload
-- verify blocklist redis
ngx.req.set_header("email", payload.email)
ngx.var.user_id = payload.id
