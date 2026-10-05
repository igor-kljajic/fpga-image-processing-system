# 2026-07-24T16:08:16.156915900
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

