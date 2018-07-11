;; init.el --- Emacs configuration

;; BASIC CUSTOMIZATION
;; --------------------------------------

;; Turn on desktop save mode:
(desktop-save-mode 1)
(setq desktop-path '("~/.emacs.d"))
(setq desktop-save 't)

;; hide the startup message
(setq inhibit-startup-message t)

;; enable line numbers globally
(global-linum-mode t)

;; disable tool bar
(tool-bar-mode -1)

;; don't leave any "~" turds lying around
(setq make-backup-files nil)



;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8
    solarized-theme
    exec-path-from-shell
    web-mode
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; load solarized dark theme
;; See https://github.com/bbatsov/solarized-emacs/blob/master/README.md
;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Don't change the font for some headings and titles
;(setq solarized-use-variable-pitch nil)

;; make the modeline high contrast
(setq solarized-high-contrast-mode-line t)

;; Use less bolding
;(setq solarized-use-less-bold t)

;; Use more italics
;(setq solarized-use-more-italic t)

(load-theme 'solarized-dark t)

;; Pick up needed shell variables when starting from the Dock/Finder
(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-variables
        '("PATH"
          "MANPATH"
          "WORKON_HOME"
          "PROJECT_HOME"))
  (exec-path-from-shell-initialize))
;;(exec-path-from-shell-copy-env "WORKON_HOME")
;;(exec-path-from-shell-copy-env "PROJECT_HOME")

;;
;; web-mode setup
;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)



;;
;; Enable emacs lisp python stuff
;;
(elpy-enable)

;; Set the interactive python interpreter used
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Use a separate shell for each python buffer
(add-hook 'elpy-mode-hook (lambda ()
                            (elpy-shell-toggle-dedicated-shell 1)))

;; switch to interpreter buffer when sending to it
(setq elpy-shell-display-buffer-after-send t) ;; display comp. buffer

;; scroll to bottom of interpreter window on input
(setq comint-scroll-to-bottom-on-input t)

;; javascript indent 
(setq js-indent-level 2)

;; shorthands
(defalias 'config 'elpy-config)
(defalias 'workon 'pyvenv-workon)
(defalias 'deactivate 'pyvenv-deactivate)

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (exec-path-from-shell solarized-theme py-autopep8 flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
