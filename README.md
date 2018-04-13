# aws-helpers

Simple repo to toss misc aws helpers. Mostly cli wrapping scripts to make life a little easier for DevOp'ers.

### What's in here?

.... not much at the moment.

**list-instances-in-regions.fish**: 
an ec2 instance describer that can walk through all regions, or hone in on a specific one.

Example usage:

```
# list all instances in the us-east-1 region
aws-vault exec myco-dev -- ./list-instances-in-regions.fish -r us-east-1

# output
Retrieving instances from region us-east-1 ...
[
    [
        {
            "ID": "i-amaninstance",
            "State": "running",
            "InstanceType": "t2.micro",
            "LaunchTime": "2018-01-01T01:01:01.000Z",
            "Tags": [
                "website"
            ]
        }
    ]
]
... done.


# list all instances in all regions
aws-vault exec myco-dev -- ./list-instances-in-regions.fish --all

# list all instances in the us-east-1 region, group by instance type and sort in reverse numerical order
aws-vault exec myco-dev -- ./list-instances-in-regions.fish -r us-east-1 | grep InstanceType | sort | uniq -c | sort -nr

# output
   2             "InstanceType": "m4.large",
   1             "InstanceType": "m4.2xlarge",

```