# 2026-07-25T11:00:42.106213300
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

status = comp.clean()

comp.build()

client.delete_component(name="app_component")

client.delete_component(name="componentName")

comp = client.create_app_component(name="app_component",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_ps7_cortexa9_0")

comp.build()

comp.build()

comp.build()

comp.build()

comp.build()

