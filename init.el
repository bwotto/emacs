(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style
   (quote
    ((c-mode . "ellemtel")
     (c++-mode . "ellemtel")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(company-backends
   (quote
    (company-irony company-cmake company-semantic company-capf company-gtags company-keywords company-etags company-xcode company-cmake company-capf company-files
		   (company-dabbrev-code company-gtags company-etags company-keywords)
		   company-oddmuse company-dabbrev)))
 '(company-etags-everywhere t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(ede-project-directories (quote ("c:/msys64/home/Benji/game/src")))
 '(exec-path
   (quote
    ("c:/msys64/mingw64/bin" "C:/msys64/usr/local/bin" "C:/msys64/usr/bin" "C:/msys64/usr/bin" "C:/Windows/System32" "C:/Windows" "C:/Windows/System32/Wbem" "C:/Windows/System32/WindowsPowerShell/v1.0/" "c:/msys64/mingw64/libexec/emacs/25.2/x86_64-w64-mingw32" "c:/msys64/mingw64/lib")))
 '(global-company-mode t)
 '(global-flycheck-mode t)
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
    (company-irony-c-headers yasnippet-snippets company-irony irony-eldoc yasnippet company-rtags company irony auto-complete-clang cmake-ide solarized-theme monokai-theme company-c-headers color-theme)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587)
 '(yas-use-menu (quote full)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 145 :width normal :foundry "outline" :family "Courier New")))))
(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "<f6>") 'gdb)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Windows performance tweaks
;;
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(add-hook 'irony-mode-hook #'irony-eldoc)
(setq c-hungry-delete-key t)
