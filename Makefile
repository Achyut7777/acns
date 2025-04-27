# Makefile

.PHONY: all clean

# lengths of your two encrypted segments
BASIC_LEN := 184
ADV_LEN   := 396

all: chooseyourfighter.red

chooseyourfighter.red: in.bin xor.py
	@echo "[*] Preparing segment…"
	@if env | grep -Eq "[QWERTYUIOPLKJHGF]{9}="; then \
	  echo "    → secret present; taking ADVANCED block ($(ADV_LEN) bytes)"; \
	  dd if=in.bin bs=1 skip=$(BASIC_LEN) count=$(ADV_LEN) of=segment.enc status=none; \
	else \
	  echo "    → no secret; taking BASIC block ($(BASIC_LEN) bytes)"; \
	  dd if=in.bin bs=1 count=$(BASIC_LEN)        of=segment.enc status=none; \
	fi

	@echo "[*] Decrypting segment…"
	@echo -n "$$(env | grep -E "[QWERTYUIOPLKJHGF]{9}=" || true)" \
	  | md5sum \
	  | sha256sum \
	  | cut -d' ' -f1 \
	  | python3 xor.py segment.enc chooseyourfighter.red

	@rm -f segment.enc
	@echo "✔ chooseyourfighter.red generated"

clean:
	@rm -f chooseyourfighter.red segment.enc
	@echo "[*] Cleaned up."
