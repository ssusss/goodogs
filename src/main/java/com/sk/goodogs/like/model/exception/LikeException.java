package com.sk.goodogs.like.model.exception;

/**
 * @author 전수경
 *
 */
public class LikeException extends RuntimeException{

	public LikeException() {
		super();
	}

	public LikeException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public LikeException(String message, Throwable cause) {
		super(message, cause);
	}

	public LikeException(String message) {
		super(message);
	}

	public LikeException(Throwable cause) {
		super(cause);
	}

}
