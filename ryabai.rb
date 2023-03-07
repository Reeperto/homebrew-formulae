# typed: false

# frozen_string_literal: true

# ryabai.rb
class Ryabai < Formula
  env :std
  desc "Fork of Yabai for personal use"
  homepage "https://github.com/Reeperto/yabai"
  head "https://github.com/Reeperto/yabai.git"

  depends_on :macos => :high_sierra

  def clear_env
    ENV.delete("CFLAGS")
    ENV.delete("LDFLAGS")
    ENV.delete("CXXFLAGS")
  end

  def install
    clear_env
    (var/"log/yabai").mkpath

    system "make", "-j1", "install"
    system "codesign", "--force", "-s", "-", "#{buildpath}/bin/yabai"

    bin.install "#{buildpath}/bin/yabai"
  end

    plist_options :manual => "yabai"

  service do

    run opt_bin/"yabai"
    require_root true
    environment_variables HOMEBREW_PREFIX/"bin:/usr/bin:/bin:/usr/sbin:/sbin"
    keep_alive true
    interval 30
    log_path var/"log/yabai/yabai.out.log"
    err_log_path var"/log/yabai/yabai.err.log"
    process_type :interactive

  end

  test do
    echo "Hi\n"
  end
end

