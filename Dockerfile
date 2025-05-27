# ee-kubespray-jmespath/Dockerfile
# -----------------------------------------------------------------------------
# Execution‑environment image for AWX / Automation‑Controller that pre‑installs
# **python3‑jmespath** so the `json_query` Jinja filter works during Kubespray
# runs.  This keeps everything else identical to the official community EE.
# -----------------------------------------------------------------------------

    FROM ghcr.io/ansible-community/community-ee-base:2.18.5-1

    # -----------------------------------------------------------------------------
    # The 2.18.x community‑ee image is Fedora‑based (rpm).  It carries `dnf` but no
    # APT, so we just add the native rpm, clean metadata, and drop back to the
    # unprivileged default user expected by ansible‑runner inside AWX.
    # -----------------------------------------------------------------------------
    
    USER root
    
    RUN dnf -y install --setopt=install_weak_deps=False python3-jmespath \
        && dnf clean all
    
    USER ansible
    
    # -----------------------------------------------------------------------------
    # Build / push quick‑start (assumes $CR_PAT holds a PAT with write:packages):
    #   IMAGE="ghcr.io/<OWNER>/ee-kubespray-jmespath:1"
    #   docker build -t $IMAGE .
    #   echo $CR_PAT | docker login ghcr.io -u <OWNER> --password-stdin
    #   docker push  $IMAGE
    # -----------------------------------------------------------------------------
    