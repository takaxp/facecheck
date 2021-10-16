;;; facecheck.el --- Check face at point  -*- lexical-binding: t; -*-
;; Copyright (C) 2021 Takaaki ISHIKAWA
;;
;; Author: Takaaki ISHIKAWA <takaxp at ieee dot org>
;; Keywords: extensions, convenience
;; Version: 0.0.2
;; Maintainer: Takaaki ISHIKAWA <takaxp at ieee dot org>
;; URL: https://github.com/takaxp/facecheck
;; Package-Requires: ((emacs "24.4"))
;; Twitter: @takaxp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides `facecheck-at-point'.  Click a character to check it's face.  Just enable the minor-mode by evaluating (facecheck-mode 1).

;;; Code:

(defvar facecheck-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mouse-1] 'facecheck-at-point)
    map)
  "Keymap for `facecheck'.")

(defvar facecheck--mouse-highlight nil)
(defvar facecheck--mouse-1-click-follows-link nil)

(defun facecheck--setup ()
  "Init function."
  (setq facecheck--mouse-highlight mouse-highlight
        facecheck--mouse-1-click-follows-link mouse-1-click-follows-link)
  (setq mouse-highlight nil
        mouse-1-click-follows-link nil))

(defun facecheck--abort ()
  "Abort."
  (setq mouse-highlight facecheck--mouse-highlight
        mouse-1-click-follows-link facecheck--mouse-1-click-follows-link))

;;;###autoload
(defun facecheck-at-point ()
  "Call describe face at point."
  (interactive)
  (let ((hl-line hl-line-mode))
    (when hl-line
      (hl-line-mode -1))
    (describe-face (face-at-point))
    (when hl-line
      (hl-line-mode 1))))

(define-minor-mode facecheck-mode
  "Toggle the minor mode `facecheck-mode'."
  :init-value nil
  :lighter ""
  :keymap facecheck-mode-map
  :global t
  :require 'facecheck
  :group 'facecheck
  (when window-system
    (if facecheck-mode
        (facecheck--setup)
      (facecheck--abort))))

(provide 'facecheck)

;;; facecheck.el ends here
