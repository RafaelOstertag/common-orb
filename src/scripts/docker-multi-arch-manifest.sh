docker manifest create "${IMAGE_NAME}:${IMAGE_TAG}" --amend "${IMAGE_NAME}:${IMAGE_TAG}-amd64" --amend "${IMAGE_NAME}:${IMAGE_TAG}-arm64"
