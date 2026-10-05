# 2026-07-24T20:41:25.618168200
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../hardware/image_filter_system_wrapper.xsa")

status = platform.build()

vitis.dispose()

