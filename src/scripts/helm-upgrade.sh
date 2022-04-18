helm upgrade -i -n "${K8S_NAMESPACE}" --set image.tag="${IMAGE_VERSION}" "${HELM_RELEASE}" "${HELM_CHART}"
