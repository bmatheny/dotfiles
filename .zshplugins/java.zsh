function find_java {
  if [[ ! -z "$JAVA_HOME" ]]; then
    return
  fi
  if [[ -x /usr/libexec/java_home ]]; then
    JAVA_HOME=$(/usr/libexec/java_home)
    return
  fi
  for dir in /opt/jdk /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home /usr/java/default; do
    if [[ -x $dir/bin/java ]]; then
      JAVA_HOME=$dir
      break
    fi
  done
}

# find_java
