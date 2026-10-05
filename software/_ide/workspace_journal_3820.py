# 2026-07-26T15:52:43.290190200
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

