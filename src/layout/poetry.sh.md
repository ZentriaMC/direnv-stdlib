# layout\_poetry

This is an opinionated implementation for supporting [Poetry][poetry] in direnv, based on [direnv#995][direnv-pull-995]


direnv currently [does not support][direnv-issue-592] [Poetry][poetry].  
See also tracking issue [direnv-stdlib#1][direnv-stdlib-issue-1]

[direnv-issue-592]: https://github.com/direnv/direnv/issues/592
[poetry]: https://python-poetry.org/
[direnv-pull-995]: https://github.com/direnv/direnv/pull/995
[direnv-stdlib-issue-1]: https://github.com/ZentriaMC/direnv-stdlib/issues/1

## Usage

```shell
layout poetry
```

## Notes

To use Poetry only to manage development environment dependencies of given project (e.g Ansible playbook), remove `packages` section from `pyproject.toml`
