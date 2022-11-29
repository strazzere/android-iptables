ifneq ($(TARGET_SIMULATOR),true)
  BUILD_IPTABLES := 1
endif
ifeq ($(BUILD_IPTABLES),1)

LOCAL_PATH:= $(call my-dir)

#
# Build libraries
#

# libiptc

include $(CLEAR_VARS)

LOCAL_C_INCLUDES:= \
	$(KERNEL_HEADERS) \
	$(LOCAL_PATH)/include/

LOCAL_CFLAGS:=-DNO_SHARED_LIBS

LOCAL_SRC_FILES:= \
	libiptc/libip4tc.c

LOCAL_MODULE_TAGS:=
LOCAL_MODULE:=libiptc

include $(BUILD_STATIC_LIBRARY)

# libxtables

include $(CLEAR_VARS)

LOCAL_C_INCLUDES:= \
	$(KERNEL_HEADERS) \
	$(LOCAL_PATH)/include/ \
	$(LOCAL_PATH)/iptables

LOCAL_CFLAGS:=-DNO_SHARED_LIBS -DXTABLES_LIBDIR=\"xtables_libdir_not_used\"

LOCAL_SRC_FILES:= \
	libxtables/xtables.c \
	libxtables/xtoptions.c \
	libxtables/getethertype.c \

LOCAL_MODULE_TAGS:=
LOCAL_MODULE:=libxtables

include $(BUILD_STATIC_LIBRARY)

# libext

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS:=
LOCAL_MODULE:=libext

# LOCAL_MODULE_CLASS must be defined before calling $(local-intermediates-dir)
#
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
intermediates := $(call local-intermediates-dir)

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/include/ \
	$(KERNEL_HEADERS) \
	$(intermediates)/extensions/

LOCAL_CFLAGS:=-DNO_SHARED_LIBS -DXTABLES_INTERNAL -Wno-format -Wno-missing-field-initializers
LOCAL_CFLAGS+=-Wno-pointer-bool-conversion -Wno-tautological-pointer-compare
LOCAL_CFLAGS+=-D_INIT=$*_init
LOCAL_CFLAGS+=-DIPTABLES_VERSION=\"1.8.7\"

PF_EXT_SLIB:=ah # esp 2dscp 2connmark comment addrtype conntrack 2ecn
PF_EXT_SLIB+=icmp #2mark mac hashlimit helper iprange length limit multiport
PF_EXT_SLIB+=realm #owner state physdev pkttype policy sctp standard tcp
PF_EXT_SLIB+=#DSCP ECN DNAT 2tos 2tcpmss 2ttl udp unclean CLASSIFY CONNMARK LOG
PF_EXT_SLIB+=MASQUERADE NETMAP REDIRECT REJECT #MARK MIRROR NFQUEUE NOTRACK
PF_EXT_SLIB+=SNAT ULOG # TOS TCPMSS TTL SAME statistic standard
EXT_FUNC+=$(foreach T,$(PF_EXT_SLIB),ipt_$(T))

EXT_SLIB := addrtype AUDIT bpf cgroup CHECKSUM CLASSIFY cluster comment connbytes
EXT_SLIB += connlimit connmark CONNMARK CONNSECMARK conntrack # connlabel
EXT_SLIB += cpu CT devgroup dscp DSCP ecn esp hashlimit helper HMARK # dccp
EXT_SLIB += IDLETIMER ipcomp iprange LED length limit mac mark MARK # ipvs
EXT_SLIB += multiport nfacct NFLOG NFQUEUE osf owner physdev pkttype
EXT_SLIB += policy quota2 quota rateest RATEEST recent rpfilter sctp
EXT_SLIB += SECMARK set SET socket standard statistic string SYNPROXY
EXT_SLIB += tcp tcpmss TCPMSS TEE time tos TOS TPROXY # TCPOPTSTRIP
EXT_SLIB += TRACE u32 udp

EX_EXT_FUNC+=$(foreach T,$(PF_EXT_SLIB),xt_$(T))

# generated headers

GEN_INITEXT:= $(intermediates)/extensions/gen_initext.c
$(GEN_INITEXT): PRIVATE_PATH := $(LOCAL_PATH)
$(GEN_INITEXT): PRIVATE_CUSTOM_TOOL = $(PRIVATE_PATH)/extensions/create_initext "$(EXT_FUNC)" > $@
$(GEN_INITEXT): PRIVATE_MODULE := $(LOCAL_MODULE)
$(GEN_INITEXT):
	$(transform-generated-source)

$(intermediates)/extensions/initext.o : $(GEN_INITEXT)

LOCAL_GENERATED_SOURCES:= $(GEN_INITEXT)

LOCAL_SRC_FILES:= \
	$(foreach T,$(PF_EXT_SLIB),extensions/libipt_$(T).c) \
	$(foreach T,$(EXT_SLIB),extensions/libxt_$(T).c) \
	extensions/initext.c

# LOCAL_STATIC_LIBRARIES := \
# 	libc

include $(BUILD_STATIC_LIBRARY)

#
# Build iptables
#

include $(CLEAR_VARS)

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/include/ \
	$(KERNEL_HEADERS)

LOCAL_CFLAGS:=-std=c99 -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -D_REENTRANT
LOCAL_CFLAGS+=-DENABLE_IPV4 -DENABLE_IPV6 -Wall -Werror -Wno-pointer-arith -Wno-sign-compare -Wno-unused-parameter

LOCAL_CFLAGS:=-DNO_SHARED_LIBS
LOCAL_CFLAGS+=-DIPTABLES_VERSION=\"1.8.7\" # -DIPT_LIB_DIR=\"$(IPT_LIBDIR)\"
#LOCAL_CFLAGS+=-DIPT_LIB_DIR=\"$(IPT_LIBDIR)\"

LOCAL_SRC_FILES:= \
	iptables/iptables.c \
	iptables/iptables-standalone.c \
	iptables/xtables-legacy-multi.c \
	iptables/xshared.c \
	iptables/iptables-xml.c \

LOCAL_MODULE_TAGS:=
LOCAL_MODULE:=iptables

LOCAL_STATIC_LIBRARIES := \
	libiptc \
	libext \
	libxtables

include $(BUILD_EXECUTABLE)

endif
