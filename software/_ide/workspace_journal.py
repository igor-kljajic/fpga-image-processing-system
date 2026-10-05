# 2026-07-31T18:10:32.405095600
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

comp = client.get_component(name="app_component")
comp.build()

comp.build()

vitis.dispose()

