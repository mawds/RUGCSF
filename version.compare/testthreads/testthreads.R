library("version.compare")

args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0){
  outfile = "results.rda"
} else if(length(args) == 1){
  outfile = args[1]
} else {
  stop("Too many arguments")
}

if(!exists("getMKLthreads")){
	maxthreads <- 1
	print ("Not using MKL")
} else {
	maxthreads <- getMKLthreads()
	print("Using MKL")
}
print(paste("Testing from 1 to", maxthreads,"threads"))

results <- list()
for (t in 1:maxthreads){
	results[[t]] <- version.compare::RevoBenchmark(threads = t)	
}

save(results, file = outfile)


