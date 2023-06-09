resource "aws_ecr_repository" "github_actions" {
  # name                 = "${var.name}-ecr"
  name                 = "octopus-underwater-app"
  image_tag_mutability = "MUTABLE"

  tags = merge(
    {
      "Name" = format("%s-ecr", var.name),
      "last_edited_by" = var.editor
    },
    var.app_tags,
  )
}

