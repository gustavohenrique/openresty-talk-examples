local jwt = require "resty.jwt"
ngx.req.read_body()
local form, err = ngx.req.get_post_args()
if err then
    ngx.say("please inform your email")
    ngx.exit(400)
end
local token = jwt:sign(ngx.var.jwt_secret, {
    header={
        typ="JWT",
        alg="HS256"
    },
    payload={
        id = "d61642da-8c82-4dc5-ba95-e56e5b9400af",
        email = form.email,
        iss = ngx.var.jwt_issuer,
        exp = ngx.now() + tonumber(ngx.var.jwt_duration_secs)
    }
})
ngx.say(token)
