# android-iptables

A simple repository for compiling iptables into 32/64 bit form. Mostly more up to date than anything else I could find already working online.

## Building

Just run `make` and the docker dependency with the ndk will be pulled and utilized. Or just grab the release from github actions.

## Notes

Most code pulled from AOSP at [d5cc7e9c6a5e7781d16a1b8eb0d7c63cd8839d00](https://android.googlesource.com/platform/external/iptables);
```
commit d5cc7e9c6a5e7781d16a1b8eb0d7c63cd8839d00 (HEAD -> master, tag: t_frc_con_330443020, tag: t_frc_cbr_330443000, tag: t_frc_ase_330444010, tag: t_frc_art_330443060, tag: android-t-qpr1-beta-3-gpl, tag: android-t-qpr1-beta-2-gpl, tag: android-t-qpr1-beta-1-gpl, tag: aml_uwb_331015040, tag: aml_uwb_330810010, tag: aml_tz4_331012050, tag: aml_tz4_331012040, tag: aml_tz4_331012000, tag: aml_go_wif_330911000, tag: aml_go_uwb_330912000, tag: aml_go_tz4_330912000, tag: aml_go_tet_330914010, tag: aml_go_swc_330913000, tag: aml_go_sta_330911000, tag: aml_go_sdk_330810000, tag: aml_go_sch_330911000, tag: aml_go_res_330912000, tag: aml_go_per_330912000, tag: aml_go_odp_330912000, tag: aml_go_neu_330912000, tag: aml_go_net_330913000, tag: aml_go_mpr_330912000, tag: aml_go_ase_330913000, tag: aml_go_ads_330913000, tag: aml_go_adb_330913000, tag: aml_ase_331011020, tag: aml_ads_331131000, origin/master, origin/main-16k, origin/android13-mainline-uwb-release, origin/android13-mainline-tzdata4-release, origin/android13-mainline-go-wifi-release, origin/android13-mainline-go-uwb-release, origin/android13-mainline-go-tzdata4-release, origin/android13-mainline-go-tethering-release, origin/android13-mainline-go-sdkext-release, origin/android13-mainline-go-scheduling-release, origin/android13-mainline-go-resolv-release, origin/android13-mainline-go-permission-release, origin/android13-mainline-go-os-statsd-release, origin/android13-mainline-go-odp-release, origin/android13-mainline-go-neuralnetworks-release, origin/android13-mainline-go-networking-release, origin/android13-mainline-go-mediaprovider-release, origin/android13-mainline-go-media-swcodec-release, origin/android13-mainline-go-appsearch-release, origin/android13-mainline-go-adservices-release, origin/android13-mainline-go-adbd-release, origin/android13-mainline-appsearch-release, origin/android13-mainline-adservices-release, origin/android13-frc-conscrypt-release, origin/android13-frc-cellbroadcast-release, origin/android13-frc-art-release, origin/android13-dev, origin/HEAD)
```

Along with some ideas and Makefile usage from [joshjdevl/custom-android-iptables](https://github.com/joshjdevl/custom-android-iptables)