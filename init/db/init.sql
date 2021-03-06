CREATE DATABASE IF NOT EXISTS agentdb;
USE agentdb;
CREATE USER  IF NOT EXISTS 'kwic'@'%' IDENTIFIED BY 'kwicDB5539!';
GRANT ALL PRIVILEGES ON agentdb.* TO 'kwic'@'%';
FLUSH PRIVILEGES;

/*
DROP TABLE agentdb.TBAG_AGTINF;
DROP TABLE agentdb.TBAG_CRTINF;
DROP TABLE agentdb.TBAG_SCHINF;agentdb
DROP TABLE agentdb.TBAG_TSKINF;
DROP TABLE agentdb.TBAG_SQNC;
DROP TABLE agentdb.TBAG_LOG;
DROP TABLE agentdb.TBAG_TSKBAT;
*/

CREATE TABLE IF NOT EXISTS agentdb.TBAG_AGTINF (
	AGTINF_SEQ	DECIMAL(15,0)	NOT NULL	COMMENT 'Agent 일련번호'
	,AGTINF_ID	VARCHAR(36)		NOT NULL	COMMENT 'Agent ID'
	,AGTINF_VER	VARCHAR(20)	NOT NULL	COMMENT 'Agent Version'
	,AGTINF_OS	VARCHAR(100)	NOT NULL	COMMENT 'Agent OS정보'
	,AGTINF_PRIP	VARCHAR(15)	NOT NULL	COMMENT 'Agent private IP'
	,AGTINF_PBIP	VARCHAR(15)	NOT NULL	COMMENT 'Agent public IP'
	,AGTINF_KEY		VARCHAR(32)	COMMENT 'Master Key'
	,AGTINF_YN	CHAR(1)		NOT NULL	DEFAULT 'Y'	COMMENT '사용여부'
	,AGTINF_SYNDT	VARCHAR(14)	COMMENT '마지막 동기화 시각'
	,AGTINF_RDT	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	
	,PRIMARY KEY(AGTINF_SEQ,AGTINF_ID)
) COMMENT='Agent정보'
;

CREATE TABLE IF NOT EXISTS agentdb.TBAG_CRTINF (
	CRTINF_SEQ		DECIMAL(15,0)	NOT NULL	COMMENT '인증서 일련번호'
	,CRTINF_CRTID	VARCHAR(68)		NOT NULL	COMMENT '인증서 ID'		
	,CRTINF_USRID	VARCHAR(100)	NOT NULL	COMMENT '사용자 ID'
	,AGTINF_ID		VARCHAR(36)		NOT NULL	COMMENT 'Agent ID'
	,CRTINF_CRTNM	VARCHAR(150)	NOT NULL	COMMENT '인증서명'
	,CRTINF_EXPIRE	VARCHAR(50)		NOT NULL	COMMENT '인증서 유효기간'
	,CRTINF_YN		CHAR(1)			NOT NULL	DEFAULT 'Y'	COMMENT '사용여부'
	,CRTINF_RDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	,CRTINF_UDT		TIMESTAMP	COMMENT '수정일시'
	
	,PRIMARY KEY(CRTINF_SEQ,CRTINF_CRTID)
	,INDEX IDX_UK_CRTINF_001(CRTINF_USRID,AGTINF_ID)
) COMMENT='인증서정보'
;

CREATE TABLE IF NOT EXISTS agentdb.TBAG_SCHINF (
	SCHINF_SEQ		DECIMAL(15,0)	NOT NULL	COMMENT '스케쥴 일련번호'
	,SCHINF_ID		VARCHAR(100)	NOT NULL	COMMENT '스케쥴 ID'		
	,SCHINF_USRID	VARCHAR(100)	NOT NULL	COMMENT '사용자 ID'
	,SCHINF_CRTID	VARCHAR(68)		NOT NULL	COMMENT '인증서 ID'
	,SCHINF_AGTID	VARCHAR(36)		NOT NULL	COMMENT 'Agent ID'
	,SCHINF_FCD		VARCHAR(15)		NOT NULL	COMMENT 'FCODE'
	,SCHINF_MDL		VARCHAR(50)		NOT NULL	COMMENT 'MODULE'
	,SCHINF_KN		CHAR(1)			NOT NULL	COMMENT '스케쥴 유형'
	,SCHINF_CRON	VARCHAR(100)	NOT NULL	COMMENT '스케쥴 CRON식'
	,SCHINF_DATA	JSON			NOT NULL	COMMENT '스케쥴 요청 데이터'
	,SCHINF_YN		CHAR(1)			NOT NULL	DEFAULT 'Y'	COMMENT '사용여부'
	,SCHINF_RDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	,SCHINF_UDT		TIMESTAMP	COMMENT '수정일시'
	
	,PRIMARY KEY(SCHINF_SEQ,SCHINF_ID)
	,INDEX IDX_UK_SCHINF_001(SCHINF_USRID,SCHINF_CRTID)
) COMMENT='스케쥴 정보'
;

CREATE TABLE IF NOT EXISTS agentdb.TBAG_TSKINF (
	TSKINF_SEQ		DECIMAL(15,0)	NOT NULL	COMMENT 'TASK 일련번호'
	,TSKINF_ID		VARCHAR(100)	NOT NULL	COMMENT 'TASK ID'		
	,SCHINF_ID		VARCHAR(100)	NOT NULL	COMMENT '스케쥴 ID'		
	,TSKINF_EXCDT	VARCHAR(14)		NOT NULL	COMMENT 'TASK 실행시각'
	,TSKINF_STS		CHAR(1)			NOT NULL	COMMENT 'TASK 상태'
	,AGTINF_ID		VARCHAR(36)		COMMENT '처리 Agent ID'
	,TSKINF_RST		JSON			COMMENT 'TASK 결과 데이터'
	,TSKINF_RSTDT	TIMESTAMP		NULL 		DEFAULT NULL				COMMENT 'TASK 결과 등록일시'
	,TSKINF_RDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	
	,PRIMARY KEY(TSKINF_SEQ,TSKINF_ID)
	,INDEX IDX_UK_TSKINF_001(SCHINF_ID)
) COMMENT='스케쥴TASK정보'
;

CREATE TABLE IF NOT EXISTS agentdb.TBAG_LOG (
	LOG_SEQ			INT	UNSIGNED	NOT NULL AUTO_INCREMENT	COMMENT '로그 일련번호'
	,LOG_TIME		VARCHAR(14)		NOT NULL	COMMENT '요청시간'		
	,LOG_IP			VARCHAR(15)		NOT NULL	COMMENT '요청 접근IP'		
	,LOG_URL		VARCHAR(100)	NOT NULL	COMMENT '요청 URL'
	,LOG_REQ		JSON			COMMENT '요청 데이터'
	,LOG_RES		JSON			COMMENT '응답 데이터'
	,LOG_RDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	
	,PRIMARY KEY(LOG_SEQ)
) COMMENT='요청로그정보'
;


CREATE TABLE IF NOT EXISTS agentdb.TBAG_TSKBAT (
	TSKBAT_SEQ		INT	UNSIGNED	NOT NULL AUTO_INCREMENT	COMMENT '배치 일련번호'
	,TSKBAT_ID		VARCHAR(100)	NOT NULL	COMMENT '배치 아이디'		
	,TSKBAT_NM		VARCHAR(100)	NOT NULL	COMMENT '배치명'		
	,TSKBAT_CRON	VARCHAR(100)	NOT NULL	COMMENT '배치 cron정보'
	,TSKBAT_RDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일시'
	,TSKBAT_UDT		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일시'
	
	,PRIMARY KEY(TSKBAT_SEQ)
) COMMENT='Task 할당 배치 이력'
;
			
INSERT INTO agentdb.TBAG_TSKBAT (TSKBAT_ID, TSKBAT_NM, TSKBAT_CRON) 
	SELECT 
		'Task_cron_batch', '스케쥴 Task할당 배치 서비스', '0 0/1 * * * *' 
	FROM DUAL 
	WHERE NOT EXISTS (
		SELECT 
			TSKBAT_ID, TSKBAT_NM, TSKBAT_CRON 
		FROM agentdb.TBAG_TSKBAT 
		WHERE 1=1 
			AND TSKBAT_ID = 'Task_cron_batch' 
			AND TSKBAT_NM = '스케쥴 Task할당 배치 서비스' 
			AND TSKBAT_CRON = '0 0/1 * * * *'
			
	);


/*######################################### 시퀀스 생성 시작 #########################################*/

CREATE TABLE IF NOT EXISTS agentdb.TBAG_SQNC(
	SQNC_CD		VARCHAR(200)	NOT NULL	COMMENT '시퀀스명'
	,SQNC_SQ	NUMERIC(15)	NOT NULL	COMMENT '시퀀스'
	,SQNC_STVAL	NUMERIC(15)	NOT NULL	COMMENT '시작값'
	,SQNC_MXVAL	NUMERIC(15)	NOT NULL	COMMENT 'MAX값'
	,SQNC_ICVAL	NUMERIC(15)	NOT NULL	DEFAULT 1	COMMENT '증가값'
	,SQNC_CYCLED	VARCHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT '순환여부'

	,CONSTRAINT RL_SQNC_PK
		PRIMARY KEY(SQNC_CD)
)
COMMENT='시퀀스정보';

/*#시퀀스생성*/
/*DROP PROCEDURE SP_CREATE_SEQUENCE;*/

delimiter $$
CREATE PROCEDURE IF NOT EXISTS SP_CREATE_SEQUENCE(
	i_cd		VARCHAR(200)
	,i_stval	NUMERIC(15)
	,i_mxval	NUMERIC(15)
	,i_icval	NUMERIC(15)
	,i_cycled	VARCHAR(1)
)
BEGIN
	SET @v_cd		:= i_cd;
	SET @v_stval	:= i_stval;
	SET @v_mxval	:= i_mxval;
	SET @v_icval	:= i_icval;
	SET @v_cycled	:= i_cycled;
	SET @v_exist	:= 0;

	END_TRAN:
	BEGIN
		IF @v_cd='' OR @v_stval>@v_mxval OR @v_icval<1 OR @v_cycled NOT IN ('Y','N') THEN
			LEAVE END_TRAN;
		END IF;
	
		SELECT
			@v_exist := COUNT(SQNC_SQ)
		FROM TBAG_SQNC
		WHERE SQNC_CD = @v_cd;

		IF @v_exist > 0 THEN
			LEAVE END_TRAN;
		END IF;
	
		START TRANSACTION;
			INSERT INTO TBAG_SQNC(
				SQNC_CD
				,SQNC_SQ
				,SQNC_STVAL
				,SQNC_MXVAL
				,SQNC_ICVAL
				,SQNC_CYCLED
			)VALUES(
				@v_cd
				,@v_stval-@v_icval
				,@v_stval
				,@v_mxval
				,@v_icval
				,@v_cycled
			);
		COMMIT;
		LEAVE END_TRAN;
	END;
END $$
delimiter ;


/*#시퀀스삭제*/
/*DROP PROCEDURE SP_DROP_SEQUENCE;*/

delimiter $$
CREATE PROCEDURE IF NOT EXISTS SP_DROP_SEQUENCE(
	i_cd		VARCHAR(200)
)
BEGIN
	SET @v_cd	:= i_cd;

	END_TRAN:
	BEGIN
		IF @v_cd='' THEN
			LEAVE END_TRAN;
		END IF;
	
		START TRANSACTION;
			DELETE FROM TBAG_SQNC
			WHERE SQNC_CD=@v_cd;
		COMMIT;

		LEAVE END_TRAN;
	END;
END $$
delimiter ;

/*#시퀀스증가*/
/*DROP PROCEDURE SP_NEXTVAL;*/

delimiter $$
CREATE PROCEDURE IF NOT EXISTS SP_NEXTVAL(
	IN i_cd		VARCHAR(200)
	,OUT o_sq	NUMERIC(15)
)

BEGIN
	SET @v_cd	:= i_cd;
	SET @v_sq	:= -1;
	SET @o_sq	:= -1;

	START TRANSACTION;
		UPDATE TBAG_SQNC SET
			SQNC_SQ = (CASE WHEN SQNC_MXVAL<SQNC_SQ+SQNC_ICVAL AND SQNC_CYCLED='Y' THEN SQNC_STVAL
					WHEN SQNC_MXVAL<SQNC_SQ+SQNC_ICVAL AND SQNC_CYCLED='N' THEN SQNC_SQ
					ELSE SQNC_SQ+SQNC_ICVAL END)
		WHERE SQNC_CD = @v_cd;
	COMMIT;

	SELECT
		@v_sq := IFNULL(MAX(SQNC_SQ),-1)
	FROM TBAG_SQNC
	WHERE SQNC_CD = @v_cd;

	IF @v_sq<0 THEN
		SET o_sq := NULL;
	ELSE
		SET o_sq := @v_sq;
	END IF;
END $$
delimiter ;

/*#시퀀스조회*/
/*DROP PROCEDURE SP_CURRVAL;*/

delimiter $$
CREATE PROCEDURE IF NOT EXISTS SP_CURRVAL(
	IN i_cd		VARCHAR(200)
	,OUT o_sq		NUMERIC(15)
)

BEGIN
	SET @v_cd	:= i_cd;
	SET @v_sq	:= -1;
	SET @o_sq	:= -1;

	BEGIN
		SELECT
			@v_sq := IFNULL(MAX(SQNC_SQ),-1)
		FROM TBAG_SQNC
		WHERE SQNC_CD = @v_cd;
	END;
	
	IF @v_sq<0 THEN
		SET o_sq := NULL;
	ELSE
		SET o_sq := @v_sq;
	END IF;
END $$
delimiter ;


/*기간별 데이터 삭제 이벤트 프로시저*/
delimiter $$
CREATE PROCEDURE IF NOT EXISTS SP_DELETE_TABLES(
)
BEGIN
	END_TRAN:
	BEGIN
		START TRANSACTION;
			DELETE FROM TBAG_LOG WHERE DATE(LOG_RDT) < DATE(SUBDATE(NOW(), INTERVAL 2 WEEK));	/*2WEEK LOG DELETE*/
		COMMIT;

		LEAVE END_TRAN;
	END;
END $$
delimiter ;

/*TABLE 데이터 삭제 EVENT 생성*/
/*
 * EVENT 사용 시 my.cnf 파일 설정 변경 필요.
 * ==> event_scheduler = ON 추가 후 재시작
 * */
CREATE EVENT IF NOT EXISTS EVENT_DELETE_TABLES
ON SCHEDULE 
	EVERY 1 DAY /*하루 한번 체크*/
	STARTS CURRENT_TIMESTAMP /*EVENT 최초 수행 시간*/
DO 
	CALL SP_DELETE_TABLES();
	

/*######################################### 시퀀스 생성 끝 #########################################*/
CALL SP_CREATE_SEQUENCE('AGTINF_SEQ',1,999999999999999,1,'N')
;
CALL SP_CREATE_SEQUENCE('CRTINF_SEQ',1,999999999999999,1,'N')
;
CALL SP_CREATE_SEQUENCE('SCHINF_SEQ',1,999999999999999,1,'N')
;
CALL SP_CREATE_SEQUENCE('TSKINF_SEQ',1,999999999999999,1,'N')
;
