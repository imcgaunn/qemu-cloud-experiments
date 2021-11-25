METADATA := cloudinit/trivial-meta-data.yml
USERDATA := cloudinit/trivial-user-data.yml
cloudinit/trivial-seed.img : $(METADATA) $(USERDATA)
	@echo "building image from the following metadata files: "
	@echo "<metadata>"
	@cat $(METADATA)
	@echo "---"
	@echo "<userdata>"
	@cat $(USERDATA)

clean :
	-rm -f cloudinit/trivial-seed.img
