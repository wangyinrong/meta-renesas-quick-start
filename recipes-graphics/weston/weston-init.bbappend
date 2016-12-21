FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = " \
	file://init \
	file://weston.ini \
	file://weston_ivi.ini \
	file://weston_exp.sh \
"

# Add Weston configuration script
do_install_append() {
    install -d ${D}/etc/xdg/weston

    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'ivi', 'ivi', '', d)}" = "ivi" ]; then
        install -m 644 ${WORKDIR}/weston_ivi.ini ${D}/etc/xdg/weston/weston.ini
    else
        install -m 644 ${WORKDIR}/weston.ini ${D}/etc/xdg/weston/weston.ini
    fi

    install -d ${D}/etc/profile.d
    install -m 0755 ${WORKDIR}/weston_exp.sh ${D}/etc/profile.d
}
FILES_${PN} += " /etc/xdg/weston/weston.ini \
		 /etc/profile.d/weston_exp.sh \
"
