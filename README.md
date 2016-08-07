This script verifies that all commits in the git repository have been authored
and committed by known e-mail addresses (listed in `.gitauthors` file, one
e-mail per line).

One can use the script to detect contributor's git misconfiguration with
invalid or unknown author or committer information
(e.g., `Jane Doe <jane@laptop.(none)>`).
You can also use it to assure that only authors or committers who signed a
[CLA](https://en.wikipedia.org/wiki/Contributor_License_Agreement)
are contributing to the repository (in this case `.gitauthors` should contain
a list of such people).

The intended use of the script is as part of the CI testing suite which you
can then integrate with GitHub pull request status checks (using services
like [Travis CI](https://travis-ci.org/) or [Circle CI](https://circleci.com/)
to have all pull requests automatically checked.

For CLA checking only, consider using a service like [CLAHub](https://www.clahub.com/).