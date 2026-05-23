$branches = @(
  'example-1-basic-workflow','example-2-pull-request-workflow','example-3-scheduled','example-4-environment-variable','example-5-using-secrets-feature','example-6-matrix-builds','example-7-caching-dependencies','example-8-artifacts','example-9-conditional-steps','example-10-docker-build','example-11-deploy-aws','example-12-reusable-workflow','example-13-composite-action','example-14-manual-dispatch','example-15-paths-filter','example-16-concurrency','example-17-job-dependencies','example-18-services','example-19-matrix-include','example-20-workflow-outputs','example-21-tag-trigger','example-22-npm-publish','example-23-github-api','example-24-on-label','example-25-local-action','example-26-permissions','example-27-exit-codes','example-28-matrix-exclude','example-29-approval-flow','example-30-notifications'
)

$missing = @()

foreach ($br in $branches) {
  git checkout $br | Out-Null
  $num = ($br -split '-')[1]
  $exists = Get-ChildItem -Path ".github/workflows" -Filter "example-$num*.yml" -ErrorAction SilentlyContinue
  if (-not $exists) { $missing += $br }
}

git checkout main | Out-Null

if ($missing.Count -eq 0) {
  Write-Output 'ALL_BRANCHES_HAVE_FILES'
} else {
  Write-Output ('BRANCHES_MISSING_FILES:' + ($missing -join ','))
}
