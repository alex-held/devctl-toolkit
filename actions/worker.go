package actions

import (
	"context"
	"time"

	"github.com/gobuffalo/buffalo/worker"
	"github.com/pkg/errors"

	"github.com/alex-held/devctl-toolkit/models"
	"github.com/alex-held/devctl-toolkit/models/discovery/github"
)

func addRepoWorkers(ctx context.Context, w worker.Worker) error {
	if err := w.Register("findGitHubRepos", findGitHubRepos(ctx, w)); err != nil {
		return errors.WithStack(err)
	}
	if err := w.Perform(githubJob); err != nil {
		return errors.WithStack(err)
	}
	return nil
}

var githubJob = worker.Job{
	Queue:   "default",
	Handler: "findGitHubRepos",
	Args:    worker.Args{},
}

func findGitHubRepos(ctx context.Context, w worker.Worker) worker.Handler {
	return func(args worker.Args) error {
		defer w.PerformIn(githubJob, 60*time.Minute)

	/*
		envy.Set("GITHUB_TOKEN", "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")

		token, err := envy.MustGet("GITHUB_TOKEN")
		if err != nil {
			return errors.WithStack(err)
		}
*/
		g, err := github.New(ctx, "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")
		if err != nil {
			return errors.WithStack(err)
		}
		repos, err := g.Search(ctx, "devctl-plugin")
		if err != nil {
			return errors.WithStack(err)
		}

		return models.ProcessProjects(repos)
	}
}
