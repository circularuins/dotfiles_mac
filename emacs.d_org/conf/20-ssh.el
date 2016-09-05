(require 'tramp)

(setenv "TMPDIR" "/tmp") ; MervericksとEmacs24.4で相性の問題?
(add-to-list 'tramp-default-proxies-alist
             '("jmty-new-stg" nil "/ssh:ec2-user@jmty-gateway:"))
