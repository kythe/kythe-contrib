load("@io_bazel_rules_scala//scala:scala.bzl", "scala_test")

TEST_SRCS = ["VerifierTest.scala"]

def gen_verifier_tests():
    for path in native.glob(["testdata/verified/*.scala"]):
        scala_test(
            name = path[path.rfind("/") + 1:].replace(".", "_") + "_verify",
            srcs = TEST_SRCS,
            size = "small",
            jvm_flags = [
                "-Dscala.library.location=$(location @io_bazel_rules_scala_scala_library)",
            ],
            data = [
                ":plugin",
                "@io_kythe//kythe/cxx/verifier",
                "@io_kythe//kythe/go/platform/tools/dedup_stream",
                "@io_bazel_rules_scala_scala_library",
            ] + ["//com/google/devtools/kythe/analyzers/scala:" + path],
            deps = [
                "@io_bazel_rules_scala//testing/toolchain:scalatest_classpath",
                "@io_bazel_rules_scala//third_party/utils/src/test:test_util",
                "@io_bazel_rules_scala_scala_compiler",
                "@io_bazel_rules_scala_scala_library",
            ],
        )
