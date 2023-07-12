package com.sk.goodogs.bookmark.model.exception;

/**
 * @author 전수경
 *
 */
public class BookmarkException extends RuntimeException {

	public BookmarkException() {
		super();
	}

	public BookmarkException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public BookmarkException(String message, Throwable cause) {
		super(message, cause);
	}

	public BookmarkException(String message) {
		super(message);
	}

	public BookmarkException(Throwable cause) {
		super(cause);
	}

}
