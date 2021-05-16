package grifts

import (
	"context"
	"log"

	"github.com/markbates/grift/grift"

	"github.com/alex-held/devctl-toolkit/actions"
)

var _ = grift.Namespace("db", func() {

	grift.Desc("seed", "Seeds a database")
	grift.Add("seed", func(c *grift.Context) error {
		// Add DB seeding stuff here


		app := actions.App()
		err := app.Worker.Start(context.Background())
		if err != nil {
			return err
		}

		if err := app.Serve(); err != nil {
			log.Fatal(err)
		}

		return nil
	})

})
