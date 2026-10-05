# 2026-07-24T23:42:35.304287400
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

comp = client.get_component(name="app_component")
comp.build()

comp.build()

vitis.dispose()

