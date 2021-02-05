$date = Get-Date -UFormat "%Y-%m-%d"
aws s3 sync s3://[BucketURL]/[ENTER Key here] d:\collections\umbrella\ --delete --quiet --exclude "*" --include "*$date*"
