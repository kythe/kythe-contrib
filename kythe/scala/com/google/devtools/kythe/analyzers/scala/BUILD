package(default_visibility = ["//visibility:public"])

load(
    "@io_bazel_rules_scala//scala:scala.bzl",
    "scala_binary",
    "scala_library",
    "scala_macro_library",
    "scala_test",
)
load(":verifier.bzl", "TEST_SRCS", "gen_verifier_tests")

scala_library(
    name = "analyzer",
    srcs = glob(
        ["*.scala"],
        exclude = TEST_SRCS,
    ),
    deps = [
        "//external:io_bazel_rules_scala/dependency/scala/scala_compiler",
        "@io_kythe//kythe/java/com/google/devtools/kythe/util:normalizer",
        "@io_kythe//kythe/java/com/google/devtools/kythe/util/schema",
        "@io_kythe//kythe/proto:common_java_proto",
        "@io_kythe//kythe/proto:schema_java_proto",
        "@io_kythe//kythe/proto:serving_java_proto",
        "@io_kythe//kythe/proto:storage_java_proto",
        "@com_google_protobuf//:protobuf_java",
    ],
)

scala_binary(
    name = "runplugin",
    data = [":plugin"],
    main_class = "com.google.devtools.kythe.analyzers.scala.ScalacWrapper",
    runtime_deps = [":analyzer"],
)

gen_verifier_tests()

# Put the jar exactly where we need it (at the top level)
# TODO(rbraunstein): update the scala.bzl file do take an optional plugin file
# or create scala_library_compiler_plugin rule that delegates to scala_library
genrule(
    name = "plugin",
    srcs = [
        ":analyzer_deploy.jar",
        "scalac-plugin.xml",
    ],
    outs = ["kythe-plugin.jar"],
    cmd = "$(location add_to_jar) $@ $(SRCS)",
    tools = [
        ":add_to_jar",
        # We have to make jar available here, sh_binary won't take it as deps
        # and data puts it under runfiles
        "@bazel_tools//tools/jdk",
    ],
    visibility = ["//visibility:public"],
)

sh_binary(
    name = "add_to_jar",
    srcs = ["add_to_jar.sh"],
)
