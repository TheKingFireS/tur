TERMUX_PKG_HOMEPAGE=https://github.com/REAndroid/APKEditor
TERMUX_PKG_DESCRIPTION="Android binary resource files editor"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@Veha0001"
TERMUX_PKG_VERSION="1.4.3"
TERMUX_PKG_SRCURL=https://github.com/REAndroid/APKEditor/releases/download/V${TERMUX_PKG_VERSION}/APKEditor-${TERMUX_PKG_VERSION}.jar
TERMUX_PKG_SHA256=c242f5fc4591667a0084668320d0016a20e7c2abae102c1bd4d640e11d9f60ee
TERMUX_PKG_DEPENDS="openjdk-21"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_UPDATE_TAG_TYPE="latest-release-tag"
TERMUX_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

termux_step_make_install() {
	local RAWJAR="$TERMUX_PKG_CACHEDIR/APKEditor-${TERMUX_PKG_VERSION}.jar"
	local INSTALL_PREFIX="$TERMUX_PREFIX/libexec/apkeditor/apkeditor.jar"
	# Download and install the jar
	termux_download $TERMUX_PKG_SRCURL $RAWJAR $TERMUX_PKG_SHA256
	install -Dm600 $RAWJAR $INSTALL_PREFIX
	# Process and install the wrapper script
	sed -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
		$TERMUX_PKG_BUILDER_DIR/wrapper.in \
		> $TERMUX_PREFIX/bin/$TERMUX_PKG_NAME
	chmod 700 $TERMUX_PREFIX/bin/$TERMUX_PKG_NAME
}
