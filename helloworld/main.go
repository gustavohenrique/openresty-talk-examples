package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func hi(c echo.Context) error {
	header := c.Request().Header
	userID := header.Get("user_id")
	email := header.Get("email")
	resp := fmt.Sprintf("ID: %s\nEmail: %s", userID, email)
	return c.HTML(http.StatusOK, resp)
}

func main() {
	e := echo.New()
	e.HideBanner = true
	e.Debug = true
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins:     []string{"*"},
		AllowCredentials: true,
		AllowMethods:     []string{http.MethodOptions, http.MethodGet, http.MethodPut, http.MethodPost, http.MethodDelete},
		AllowHeaders: []string{"*"},
	}))

	e.GET("/", hi)

	go func() {
		fmt.Println("Golang in 9003")
		log.Fatal(e.Start(":9003"))
	}()

	quit := make(chan os.Signal)
	signal.Notify(quit, os.Interrupt, os.Kill, syscall.SIGQUIT)
	<-quit
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	if err := e.Shutdown(ctx); err != nil {
		log.Fatal(err)
	}
}
