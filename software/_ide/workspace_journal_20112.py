# 2026-07-24T18:58:30.625686600
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

comp = client.get_component(name="app_component")
comp.build()

vitis.dispose()

