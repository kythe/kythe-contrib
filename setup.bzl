load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def kythe_contrib_rule_repositories():
    """Defines external repositories for Kythe Contrib Bazel rules.

    These repositories must be loaded before calling external.bzl%kythe_dependencies.
    """

    rules_scala_version = "5df8033f752be64fbe2cedfd1bdbad56e2033b15"

    maybe(
        http_archive,
        name = "io_bazel_rules_scala",
        sha256 = "b7fa29db72408a972e6b6685d1bc17465b3108b620cb56d9b1700cf6f70f624a",
        strip_prefix = "rules_scala-%s" % rules_scala_version,
        type = "zip",
        urls = [
            "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
        ],
    )
