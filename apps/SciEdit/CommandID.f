\ $Id: CommandID.f,v 1.9 2012/05/08 20:57:38 georgeahubert Exp $
\    File: CommandID.f
\
\  Author: Dirk Busch (dbu)
\   Email: dirkNOSPAM@win32forth.org
\
\ Created: Mittwoch, Juni 09 2004 - dbu
\ Updated: Samstag, Juli 03 2004 - 10:52 - dbu

\ Saturday, May 06 2006  Added Print and PageSetup - Rod

cr .( Loading Menu Command ID's...)

: NewID ( <name> -- )
        defined
        IF  drop
        ELSE NextID swap count ['] constant execute-parsing
        THEN ;

IdCounter constant IDM_FIRST

\ File menu
NewID IDM_NEW_SOURCE_FILE
NewID IDM_OPEN_SOURCE_FILE
NewID IDM_CLOSE
NewID IDM_SAVE
NewID IDM_SAVE_AS
NewID IDM_SAVE_ALL
NewID IDM_RELOAD
NewID IDM_OPEN_HTML_FILE
NewID IDM_PRINT
NewID IDM_PAGE_SETUP
NewID IDM_EXIT
NewID IDM_OPEN_RECENT_FILE
NewID IDM_OPEN_HIGHLIGHTED_FILE

\ Edit menu
NewID IDM_UNDO
NewID IDM_REDO
NewID IDM_CUT
NewID IDM_COPY
NewID IDM_PASTE
NewID IDM_DELETE
NewID IDM_SELECT_ALL
NewID IDM_REMOVE_SELECTION
NewID IDM_FIND_TEXT
NewID IDM_FIND_NEXT
NewID IDM_FIND_PREVIOUS
NewID IDM_FIND_IN_FILES
NewID IDM_INSERT_DATE
NewID IDM_INSERT_DATE&TIME
NewID IDM_COMMENT_BLOCK
NewID IDM_UNCOMMENT_BLOCK
NewID IDM_LOWERCASE
NewID IDM_UPPERCASE
NewID IDM_LINECUT
NewID IDM_LINEDELETE
NewID IDM_LINECOPY
NewID IDM_LINETRANSPOSE
NewID IDM_LINEDUPLICATE

\ DexH menu
NewID IDM_DEX_GLOSSARY
NewID IDM_DEX_PARAGRAPH
NewID IDM_DEX_CODE_PARAGRAPH
NewID IDM_DEX_STYLE_BOLD
NewID IDM_DEX_STYLE_ITALIC
NewID IDM_DEX_STYLE_TYPEWRITER

\ View menu
NewID IDM_VIEW_EOL
NewID IDM_VIEW_WHITESPACE
NewID IDM_VIEW_LINE_NUMBERS
NewID IDM_COLORIZE
NewID IDM_BROWSE

\ Options menu
NewID IDM_EOL_CRLF
NewID IDM_EOL_LF
NewID IDM_EOL_CR
NewID IDM_CREATE_BAK
NewID IDM_SAVE_ALL_BEFORE_COMPILE
NewID IDM_TABS
NewID IDM_SHOW_TOOLBAR
NewID IDM_SHOW_STATUSBAR
NewID IDM_REMOVE_TRAILING_WHITE
NewID IDM_ENSURE_FINAL_LINE_ENDING

\ Win32Forth menu
NewID IDM_COMPILE
NewID IDM_DEBUG
NewID IDM_VOC_BROWSER
NewID IDM_HANDLEW32FMSG

\ Window menu
NewID IDM_TILE_HORIZONTAL
NewID IDM_TILE_VERTICAL
NewID IDM_ARRANGE
NewID IDM_CASCADE
NewID IDM_CLOSE_ALL

\ Help menu
NewID IDM_W32F_ANS_HELP
NewID IDM_API_HELP
NewID IDM_W32F_HOMEPAGE
NewID IDM_W32F_FORUM
NewID IDM_W32F_DOC
NewID IDM_ANS_DOC
NewID IDM_ABOUT

\ Toolbar
NewID IDM_BACK
NewID IDM_FORWARD

IdCounter constant IDM_LAST

: allot-erase	( n -- )
		here over allot swap erase ;

Create CommandTable IDM_LAST IDM_FIRST - cells allot-erase

: IsCommand?	( ID -- f )
		IDM_FIRST IDM_LAST within ;

: >CommandTable	( ID -- addr )
		dup IsCommand?
		if   IDM_FIRST - cells CommandTable +
		else drop abort" error - command ID out of range"
		then ;

: DoCommand	( ID -- )
		>CommandTable @ ?dup IF execute THEN ;

: SetCommand	( ID -- )
		last @ name> swap >CommandTable ! ;
