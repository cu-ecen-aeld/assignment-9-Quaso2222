
##############################################################
#
# LDD
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = '27eed18790756d9d0bf4883d975dd445b6a47524'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-Quaso2222.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

# define LDD_BUILD_CMDS    
# 	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull
# 	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules
# endef
LDD_MODULE_SUBDIRS = scull misc-modules

define LDD_INSTALL_TARGET_CMDS

    $(INSTALL) -D -m 0755 $(@D)/scull/scull_load  $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	$(INSTALL) -D -m 0755 $(@D)/scull/scull_unload  $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	$(INSTALL) -D -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	$(INSTALL) -D -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	
endef
# endef

$(eval $(kernel-module))
$(eval $(generic-package))
