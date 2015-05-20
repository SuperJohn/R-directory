an_environment <- new.env()
an_environment[["pythag"]] <- c(12,15,20,21)
an_environment$root <- polyroot(c(6,-5,1))

# Assigning a value to a particular environment
assign(
    "moonday"
    , weekdays(as.Date("1969/07/20"))
    , an_environment
    )
an_environment[["pythag"]]
an_environment$root
get("moonday", an_environment)
ls(name = an_environment)
