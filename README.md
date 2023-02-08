# aws-emr
#Long-running cluster
By default, clusters that you create with the console or the AWS CLI are long-running. Long-running clusters continue to run, accept work, and accrue charges until you take action to shut them down.

A long-running cluster is effective in the following situations:

When you need to interactively or automatically query data.

When you need to interact with big data applications hosted on the cluster on an ongoing basis.

When you periodically process a data set so large or so frequently that it is inefficient to launch new clusters and load data each time.

#Ephemeral Clusters
In an ephemeral cluster strategy, the clusters are created, exist for the time it takes for jobs to complete, and then cease to exist when they are brought down.
Create a workflow to implement the strategy. An Informatica workflow contains Command tasks that use scripts that spin up and configure an Amazon EMR cluster, and Mapping tasks that run mappings. When the mapping runs are complete, additional Command tasks can then terminate the cluster, so that you use Amazon EMR cluster resources only when you need them.
