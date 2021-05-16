package grifts

import (
	"github.com/gobuffalo/buffalo"

	"github.com/alex-held/devctl-toolkit/actions"
)

func init() {
	buffalo.Grifts(actions.App())
}
