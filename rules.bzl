def _my_manifest_impl(ctx):
    ctx.actions.run(
        inputs = ctx.files.srcs + [ctx.file.template],
        outputs = [ctx.outputs.out],
        arguments = [
            ctx.file.template.path, ctx.outputs.out.path
        ] + [ f.path for f in ctx.files.srcs ],
        executable = ctx.executable._hash,
        use_default_shell_env = True,
    )

my_manifest = rule(
    implementation = _my_manifest_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "template": attr.label(
            mandatory = True,
            single_file = True,
            allow_files = True,
        ),
        "out": attr.output(mandatory = True),
        "_hash": attr.label(
            cfg = "host",
            executable = True,
            allow_files = True,
            default = Label("//:hash"),
        ),
    },
    output_to_genfiles = True,
)
