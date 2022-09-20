FROM gitpod/openvscode-server:latest

# Install Python and other dependencies
RUN sudo apt-get update -y
RUN sudo apt-get install python3 python3-venv python3-pip libarchive-tools default-jdk -y


# Install vscode extensions (see: https://github.com/gitpod-io/openvscode-server/issues/94)
RUN EXT_PUBLISHER=ms-python EXT_PACKAGE=python && \
    mkdir -pv "/home/workspace/.openvscode-server/extensions/${EXT_PUBLISHER}.${EXT_PACKAGE}" && \
    curl -sSL "https://${EXT_PUBLISHER}.gallery.vsassets.io/_apis/public/gallery/publisher/${EXT_PUBLISHER}/extension/${EXT_PACKAGE}/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage" \
    | bsdtar xvf - --strip-components=1 -C "/home/workspace/.openvscode-server/extensions/${EXT_PUBLISHER}.${EXT_PACKAGE}"

# Install pip dependencies
RUN pip install notebook pandas pyspark==3.3.0 pyarrow

