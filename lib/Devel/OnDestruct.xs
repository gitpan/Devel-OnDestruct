#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

static int call_free(pTHX_ SV* var, MAGIC* magic) {
	dSP;
	PUSHMARK(SP);
	call_sv(magic->mg_obj, G_VOID | G_DISCARD);
}

static const MGVTBL magic_table  = { 0, 0, 0, 0, call_free };

static SV* deref_var(pTHX_ SV* var_ref) {
	if (!SvROK(var_ref))
		Perl_croak(aTHX_ "Invalid argument!");
	return SvRV(var_ref);
}

MODULE = Devel::OnDestruct				PACKAGE = Devel::OnDestruct

PROTOTYPES: DISABLED

void
on_destruct(value, subref)
	SV* value = deref_var(aTHX_ ST(0));
	CV* subref;
	PROTOTYPE: \[$@%*&]@
	CODE:
	sv_magicext(value, (SV*)subref, PERL_MAGIC_ext, &magic_table, NULL, 0);
