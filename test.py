import subprocess
import time
import shutil
import os

# --- Configuration ---
ENV_VAR_NAME = "GHTEQJWKW"
TGZ_FILENAME = "sontiachyutaram.tgz"
FINAL_DESTINATION = "tarballs"
BASIC_RED = "basic_warrior.red"
ADVANCED_RED = "advanced_warrior.red"

# --- Helper function to run shell commands ---
def run(cmd, sleep_time=1, env=None, allow_failure=False):
    print(f"\n$ {cmd}")
    try:
        subprocess.run(cmd, shell=True, check=True, env=env)
    except subprocess.CalledProcessError as e:
        if allow_failure and e.returncode == 1:
            print(f"⚠️ Expected no match: {cmd}")
        else:
            raise
    time.sleep(sleep_time)

# --- Main steps ---
try:
    print("\n🚀 Starting full regeneration process!")

    # Step 1: Clean old files
    run("rm -f basic.txt basic_enc.txt basic.bin advanced.txt advanced_enc.txt advanced.bin in.bin out.bin chooseyourfighter.red", sleep_time=2)

    # Step 2: Prepare environment variable handling
    base_env = os.environ.copy()
    if ENV_VAR_NAME in base_env:
        del base_env[ENV_VAR_NAME]
    adv_env = os.environ.copy()
    adv_env[ENV_VAR_NAME] = "1"

    # Step 3: Capture basic.txt (expect no match)
    run(f"env | grep \"{ENV_VAR_NAME}\" > basic.txt", sleep_time=1, env=base_env, allow_failure=True)

    # Step 4: Create basic_enc.txt
    run("cat basic.txt | md5sum | sha256sum > basic_enc.txt", sleep_time=1)

    # Step 5: Encrypt basic.red -> basic.bin
    run(f"cat basic_enc.txt | python3 xor.py {BASIC_RED} basic.bin", sleep_time=2)

    # Step 6: Capture advanced.txt (should match)
    run(f"env | grep \"{ENV_VAR_NAME}\" > advanced.txt", sleep_time=1, env=adv_env)

    # Step 7: Create advanced_enc.txt
    run("cat advanced.txt | md5sum | sha256sum > advanced_enc.txt", sleep_time=1)

    # Step 8: Encrypt advanced.red -> advanced.bin
    run(f"cat advanced_enc.txt | python3 xor.py {ADVANCED_RED} advanced.bin", sleep_time=2)

    # Step 9: Validate file sizes and encryption keys
    basic_bin_size = os.path.getsize("basic.bin")
    advanced_bin_size = os.path.getsize("advanced.bin")
    print(f"\n📏 basic.bin size: {basic_bin_size} bytes")
    print(f"📏 advanced.bin size: {advanced_bin_size} bytes")

    with open("basic_enc.txt") as f:
        basic_enc = f.read().strip()
    with open("advanced_enc.txt") as f:
        advanced_enc = f.read().strip()

    if basic_enc == advanced_enc:
        raise Exception("❌ ERROR: basic_enc.txt and advanced_enc.txt are identical! Something went wrong with environment setup.")

    if basic_bin_size == 0 or advanced_bin_size == 0:
        raise Exception("❌ ERROR: One of the binaries is empty. Cannot proceed.")

    # Step 10: Combine both binaries into in.bin
    run("cat basic.bin advanced.bin > in.bin", sleep_time=2)

    # Step 11: Create tarball
    run(f"tar -czf {TGZ_FILENAME} Makefile xor.py in.bin", sleep_time=2)

    # Step 12: Copy tarball to destination
    if not os.path.exists(FINAL_DESTINATION):
        os.makedirs(FINAL_DESTINATION)
    shutil.copy(TGZ_FILENAME, FINAL_DESTINATION)

    print("\n✅ Successfully regenerated and copied:")
    print(f"- {TGZ_FILENAME} -> {FINAL_DESTINATION}")

except subprocess.CalledProcessError as e:
    print(f"\n❌ Command failed: {e.cmd}")
    exit(1)
except Exception as ex:
    print(f"\n❌ Unexpected error: {ex}")
    exit(1)
