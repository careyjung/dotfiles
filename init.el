;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; https://github.com/bbatsov/solarized-emacs/blob/master/README.md
(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    solarized-theme
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")

(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Separate shell for each python buffer
(add-hook 'elpy-mode-hook (lambda ()
                            (elpy-shell-toggle-dedicated-shell 1)))

;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'solarized-dark t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(tool-bar-mode -1) ;; disable tool bar
(setq make-backup-files nil) ;; stop leaving those damn ~ turds lying around
(setq comint-scroll-to-bottom-on-input t) ;; self-explanatory
(setq js-indent-level 2)
(setq elpy-shell-display-buffer-after-send t) ;; display comp. buffer

;; Desktop save mode:
;; - only look in current dir
;; - only save if it exists (so requires manual first save)
(desktop-save-mode 1)
(setq desktop-path '("."))
(setq desktop-save 'if-exists)

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (solarized-theme material-theme flycheck elpy better-defaults)))
 '(solarized-high-contrast-mode-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

