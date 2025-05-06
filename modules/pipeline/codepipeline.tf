
resource "aws_codepipeline" "codepipeline" {
  name     = "${var.prefix}-${var.environment}-pipeline"
  role_arn = aws_iam_role.codepipeline_service_role.arn

  artifact_store {
    location = var.bucket_artifact_name
    type     = "S3"
    # encryption_key {
    #   id   = aws_kms_key.pipeline_artifact.arn
    #   type = "KMS"
    # }
  }

  stage {
    name = "Source"
    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceOutput"]
      # configuration = {
      #   ConnectionArn     = var.codestar_connection_arn
      #   FullRepositoryId  = var.github_repository_path
      #   BranchName        = var.github_branch_name
      #   DetectChanges     = "true"
      # } 
      configuration = {
        Owner      = var.github_repository_username
        Repo       = var.github_repository_name
        Branch     = var.github_branch_name
        OAuthToken = jsondecode(data.aws_secretsmanager_secret_version.github_token_version.secret_string)["token"]
      }
      run_order = 1
    }
  }

  stage {
    name = "BuildAndDeploy"
    action {
      name             = "BuildAndDeploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
      configuration = {
        ProjectName = aws_codebuild_project.build_and_deploy.name
      }
      run_order = 1
    }
  }

}
