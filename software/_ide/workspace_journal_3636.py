# 2026-07-23T22:01:07.866844700
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

comp = client.get_component(name="app_component")
comp.build()

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

vitis.dispose()

