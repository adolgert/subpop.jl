using subpop
using Documenter

makedocs(;
    modules=[subpop],
    authors="Drew Dolgert <adolgert@uw.edu> and contributors",
    repo="https://github.com/adolgert/subpop.jl/blob/{commit}{path}#L{line}",
    sitename="subpop.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://adolgert.github.io/subpop.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/adolgert/subpop.jl",
)
