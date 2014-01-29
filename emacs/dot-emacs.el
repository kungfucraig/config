;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(setq tab-width 3)
(setq make-backup-files nil)
(require 'font-lock)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(blink-cursor-mode 0)
(transient-mark-mode 1)
;;(tool-bar-mode 0)
(setq-default indent-tabs-mode nil)
(setq next-line-add-newlines nil)
(server-start)
(put 'set-goal-column 'disabled nil)
(setq visible-bell t)
(show-paren-mode t)
(blink-cursor-mode nil)
(column-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Terminal (tmux) mouse
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Killing trailing white space after lines.
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ido
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Uniquify
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Map some keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f3] 'bookmark-bmenu-list)
(global-set-key [f4] 'bookmark-set)
(global-set-key [f6] 'copy-to-register)
(global-set-key [f7] 'insert-register)
;;(global-set-key [?\C-x?\h] 'eshell)
(global-set-key [?\C-x?\h] 'shell)
(global-set-key [?\C-x?\_] 'revert-buffer)
(global-set-key "\C-x\-" 'bury-buffer)
(global-set-key "\C-x\g" 'goto-line)
(global-set-key [?\M-n] 'scroll-up)
(global-set-key [?\M-p] 'scroll-down)
(global-set-key [C-kp-home] 'beginning-of-buffer)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-kp-end] 'end-of-buffer)
(global-set-key [C-end] 'end-of-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Viper Mode Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq viper-mode t)
;;(setq viper-ex-style-editing nil) ; can backspace past start of insert/line
(setq viper-inhibit-startup-message t)
(setq viper-expert-level '5)
(require 'viper)

;;(setq vimpulse-experimental nil) ; turn off bleeding edge features
(add-to-list 'load-path "~/dev-misc/src/vimpulse")
(require 'redo)
(require 'vimpulse)
(setq-default viper-auto-indent t)
(setq-default tab-width 2)
(setq-default viper-shift-width 2)

(define-key viper-insert-basic-map (kbd "C-g") 'viper-exit-insert-state)
(define-key viper-vi-basic-map (kbd "C-i") 'indent-for-tab-command)
