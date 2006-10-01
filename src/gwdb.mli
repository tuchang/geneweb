(* $Id: gwdb.mli,v 5.35 2006-09-30 21:48:46 ddr Exp $ *)
(* Copyright (c) 1998-2006 INRIA *)

open Adef;

type person = 'abstract;
type ascend = 'abstract;
type union = 'abstract;

type family = 'abstract;
type couple = 'abstract;
type descend = 'abstract;

type relation = Def.gen_relation iper istr;
type title = Def.gen_title istr;

type rn_mode = [ RnAll | Rn1Ch | Rn1Ln ];

type notes =
  { nread : string -> rn_mode -> string;
    norigin_file : string;
    efiles : unit -> list string }
;

type record_access 'a =
  { load_array : unit -> unit;
    get : int -> 'a;
    len : mutable int;
    array_obj : unit -> array 'a;
    clear_array : unit -> unit }
;

type istr_iper_index =
  { find : istr -> list iper;
    cursor : string -> istr;
    next : istr -> istr }
;

type visible_record_access =
  { v_write : unit -> unit;
    v_get : (person -> bool) -> int -> bool }
;

type base_data =
  { persons : record_access person;
    ascends : record_access ascend;
    unions : record_access union;
    visible : visible_record_access;
    families : record_access family;
    couples : record_access couple;
    descends : record_access descend;
    strings : record_access string;
    particles : list string;
    bnotes : notes }
;

type base_func =
  { persons_of_name : string -> list iper;
    strings_of_fsname : string -> list istr;
    index_of_string : string -> istr;
    persons_of_surname : istr_iper_index;
    persons_of_first_name : istr_iper_index;
    patch_person : iper -> person -> unit;
    patch_ascend : iper -> ascend -> unit;
    patch_union : iper -> union -> unit;
    patch_family : ifam -> family -> unit;
    patch_couple : ifam -> couple -> unit;
    patch_descend : ifam -> descend -> unit;
    patch_string : istr -> string -> unit;
    patch_name : string -> iper -> unit;
    commit_patches : unit -> unit;
    commit_notes : string -> string -> unit;
    patched_ascends : unit -> list iper;
    is_patched_person : iper -> bool;
    cleanup : unit -> unit }
;

type base =
  { data : base_data;
    func : base_func }
;

value get_access : person -> Def.access;
value get_aliases : person -> list istr;
value get_baptism : person -> codate;
value get_baptism_place : person -> istr;
value get_baptism_src : person -> istr;
value get_birth : person -> codate;
value get_birth_place : person -> istr;
value get_birth_src : person -> istr;
value get_burial : person -> Def.burial;
value get_burial_place : person -> istr;
value get_burial_src : person -> istr;
value get_death : person -> Def.death;
value get_death_place : person -> istr;
value get_death_src : person -> istr;
value get_first_name : person -> istr;
value get_first_names_aliases : person -> list istr;
value get_image : person -> istr;
value get_key_index : person -> iper;
value get_notes : person -> istr;
value get_occ : person -> int;
value get_occupation : person -> istr;
value get_psources : person -> istr;
value get_public_name : person -> istr;
value get_qualifiers : person -> list istr;
value get_related : person -> list iper;
value get_rparents : person -> list relation;
value get_sex : person -> Def.sex;
value get_surname : person -> istr;
value get_surnames_aliases : person -> list istr;
value get_titles : person -> list title;

value person_with_key : person -> istr -> istr -> int -> person;
value person_with_related : person -> list iper -> person;
value person_with_rparents : person -> list relation -> person;
value person_with_sex : person -> Def.sex -> person;
value person_of_gen_person : Def.gen_person iper istr -> person;
value gen_person_of_person : person -> Def.gen_person iper istr;

value get_parents : ascend -> option ifam;
value get_consang : ascend -> Adef.fix;

value ascend_with_consang : ascend -> Adef.fix -> ascend;
value ascend_with_parents : ascend -> option ifam -> ascend;
value ascend_of_gen_ascend : Def.gen_ascend ifam -> ascend;

value get_family : union -> array ifam;

value union_of_gen_union : Def.gen_union ifam -> union;

value get_comment : family -> istr;
value get_divorce : family -> Def.divorce;
value get_fam_index : family -> ifam;
value get_fsources : family -> istr;
value get_marriage : family -> codate;
value get_marriage_place : family -> istr;
value get_marriage_src : family -> istr;
value get_origin_file : family -> istr;
value get_relation : family -> Def.relation_kind;
value get_witnesses : family -> array iper;

value family_of_gen_family : Def.gen_family iper istr -> family;
value gen_family_of_family : family -> Def.gen_family iper istr;

value get_father : couple -> iper;
value get_mother : couple -> iper;
value get_parent_array : couple -> array iper;

value couple_of_gen_couple : Def.gen_couple iper -> couple;
value gen_couple_of_couple : couple -> Def.gen_couple iper;

value get_children : descend -> array iper;

value descend_of_gen_descend : Def.gen_descend iper -> descend;
value gen_descend_of_descend : descend -> Def.gen_descend iper;

value poi : base -> iper -> person;
value aoi : base -> iper -> ascend;
value uoi : base -> iper -> union;

value foi : base -> ifam -> family;
value coi : base -> ifam -> couple;
value doi : base -> ifam -> descend;

value sou : base -> istr -> string;

value nb_of_persons : base -> int;
value nb_of_families : base -> int;
value nb_of_strings : base -> int;

value patch_person : base -> iper -> person -> unit;
value patch_ascend : base -> iper -> ascend -> unit;
value patch_union : base -> iper -> union -> unit;
value patch_family : base -> ifam -> family -> unit;
value patch_descend : base -> ifam -> descend -> unit;
value patch_couple : base -> ifam -> couple -> unit;
value patch_name : base -> string -> iper -> unit;
value patch_string : base -> istr -> string -> unit;
value commit_patches : base -> unit;
value commit_notes : base -> string -> string -> unit;
value is_patched_person : base -> iper -> bool;
value patched_ascends : base -> list iper;

value persons_of_name : base -> string -> list iper;
value persons_of_first_name : base -> istr_iper_index;
value persons_of_surname : base -> istr_iper_index;

value base_visible_get : base -> (person -> bool) -> int -> bool;
value base_visible_write : base -> unit;
value base_index_of_string : base -> string -> istr;
value base_particles : base -> list string;
value base_strings_of_fsname : base -> string -> list istr;
value base_cleanup : base -> unit;

value load_ascends_array : base -> unit;
value load_unions_array : base -> unit;
value load_couples_array : base -> unit;
value load_descends_array : base -> unit;
value load_strings_array : base -> unit;

value ascends_array : base -> array ascend;

value base_notes_read : base -> string -> string;
value base_notes_read_first_line : base -> string -> string;
value base_notes_read_first_char : base -> string -> string;
value base_notes_origin_file : base -> string;

value p_first_name : base -> person -> string;
value p_surname : base -> person -> string;

value person_misc_names :
  base -> person -> (person -> list title) -> list string
;