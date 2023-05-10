# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

##
@InstallGlobalFunction( CAP_INTERNAL_FUNC_FOR_MONOIDAL_STRUCTURES,
  function( key_val_rec, package_name )
    local L, name, pos;
    
    L = [ "IsMonoidalCategory",
           "IsStrictMonoidalCategory",
           "IsBraidedMonoidalCategory",
           "IsSymmetricMonoidalCategory",
           "AdditiveMonoidal",
           "TensorProductOnObjects",
           "TensorProduct",
           "TensorUnit",
           "Associator",
           "LeftUnitor",
           "RightUnitor",
           "Distributivity",
           "DirectSum",
           "Braiding",
           ["Lambda", "CoLambda"],
           ["Evaluation", "CoclosedEvaluation"],
           ["Coevaluation", "CoclosedCoevaluation"],
           "MONOIDAL",
           "Monoidal",
           "monoidal",
           "DISTRIBUTIVE",
           "tensor_object",
           "tensored",
           "otimes",
           "oplus",
           "tensor_product",
           "tensorSproduct",
           "AdditiveS",
           "BraidedS",
           "TensorProductOnObjectsBCcat",
           "CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE",
           ];
    
    for name in L
        if IsList( name ) && !IsString( name )
            if !IsBound( key_val_rec[name[1]] )
                if !IsBound( key_val_rec[name[2]] )
                    Error( "both components with the names ", name[1], " && ", name[2], " are missing ⥉ the given key_value_record record\n" );
                else
                    pos = Position(L, name);
                    L[pos] = name[2];
                end;
            else
                pos = Position(L, name);
                L[pos] = name[1];
            end;
        elseif !IsBound( key_val_rec[name] )
            Error( "the component with the name ", name, " is missing ⥉ the given key_value_record record\n" );
        end;
    end;
    
    L = List( L[(1):(Length( L ) - 5)], name -> [ name, key_val_rec[name] ] );
    
    L = @Concatenation(
                 [ [ "\"MonoidalCategories\",", @Concatenation( "\"", package_name, "\"," ) ],
                   [ @Concatenation( PackageInfo( "MonoidalCategories" )[1].PackageName, ": ", PackageInfo( "MonoidalCategories" )[1].Subtitle ),
                     @Concatenation( PackageInfo( package_name )[1].PackageName, ": ", PackageInfo( package_name )[1].Subtitle ) ],
                   [ "TensorProductOnObjects( cat,", key_val_rec.TensorProductOnObjectsBCcat ],
                   [ "METHOD_NAME_RECORD, \"MonoidalCategories\"", key_val_rec.CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE ],
                   ], L );
    
    Add( L, [ "tensor product", key_val_rec.tensorSproduct ] );
    Add( L, [ "Additive ", key_val_rec.AdditiveS ] );
    Add( L, [ "Braided ", key_val_rec.BraidedS ] );
    
    if IsBound( key_val_rec.replace )
        Append( L, key_val_rec.replace );
    end;
    
    if IsBound( key_val_rec.safe_replace )
        L = @Concatenation(
                     List( key_val_rec.safe_replace, r -> [ r[1], ShaSum( r[1] ) ] ), ## detect at the very beginning && replace by sha's (order is important!)
                     L,
                     List( key_val_rec.safe_replace, r -> [ ShaSum( r[1] ), r[2] ] ) ); ## safely replace the sha's at the very end
    end;
    
    return L;
    
end );

##
@InstallGlobalFunction( WriteFileForMonoidalStructure,
  function( key_val_rec, package_name, files_rec )
    local dir, L, files, header, file, source, target;
    
    L = CAP_INTERNAL_FUNC_FOR_MONOIDAL_STRUCTURES( key_val_rec, package_name );
    
    dir = @Concatenation( PackageInfo( "MonoidalCategories" )[1].InstallationPath, "/gap/" );
    
    files = [ "MonoidalCategoriesTensorProductAndUnit_gd",
               "MonoidalCategoriesTensorProductAndUnitTest_gd",
               "MonoidalCategories_gd",
               "MonoidalCategoriesTest_gd",
               "AdditiveMonoidalCategories_gd",
               "AdditiveMonoidalCategoriesTest_gd",
               "BraidedMonoidalCategories_gd",
               "BraidedMonoidalCategoriesTest_gd",
               "MonoidalCategoriesTensorProductAndUnitMethodRecord_gi",
               "MonoidalCategoriesTensorProductAndUnit_gi",
               "MonoidalCategoriesTensorProductAndUnitTest_gi",
               "MonoidalCategoriesMethodRecord_gi",
               "MonoidalCategories_gi",
               "MonoidalCategoriesTest_gi",
               "AdditiveMonoidalCategoriesMethodRecord_gi",
               "AdditiveMonoidalCategories_gi",
               "AdditiveMonoidalCategoriesTest_gi",
               "BraidedMonoidalCategoriesProperties_gi",
               "BraidedMonoidalCategoriesMethodRecord_gi",
               "BraidedMonoidalCategories_gi",
               "BraidedMonoidalCategoriesTest_gi",
               "SymmetricMonoidalCategoriesProperties_gi",
               "MonoidalCategoriesDerivedMethods_gi",
               "AdditiveMonoidalCategoriesDerivedMethods_gi",
               "BraidedMonoidalCategoriesDerivedMethods_gi",
               "SymmetricMonoidalCategoriesDerivedMethods_gi",
               ];
    
    header = @Concatenation(
                      "# THIS FILE WAS AUTOMATICALLY GENERATED",
                      "\n\n" );
    
    for file in files
        if !IsBound( files_rec[file] )
            Info( InfoWarning, 1, "the component ", file, " is !bound ⥉ the record 'files_rec'" );
        elseif IsString( files_rec[file] )
            source = @Concatenation( dir, ReplacedString( file, "_", "." ) );
            target = @Concatenation( PackageInfo( package_name )[1].InstallationPath, "/gap/", files_rec[file] );
            WriteReplacedFileForHomalg( source, L, target; header = header );
        end;
    end;
    
    if IsBound( files_rec.AUTOGENERATED_FROM )
        target = @Concatenation( PackageInfo( package_name )[1].InstallationPath, "/gap/", files_rec.AUTOGENERATED_FROM );
        WriteFileForHomalg(
                target,
                @Concatenation(
                        "The files of this package which include the line",
                        " `THIS FILE WAS AUTOMATICALLY GENERATED` ⥉ their header",
                        " have been autogenerated\n\n",
                        "* from MonoidalCategories v",
                        PackageInfo( "MonoidalCategories" )[1].Version,
                        "\n" ) );
    end;
    
end );
