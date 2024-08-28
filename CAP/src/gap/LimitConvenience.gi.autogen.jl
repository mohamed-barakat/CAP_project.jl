# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

@InstallGlobalFunction( "CAP_INTERNAL_GENERATE_CONVENIENCE_METHODS_FOR_LIMITS",
  function ( package_name, method_name_record, limits )
    local output_string, generate_universal_morphism_convenience, generate_functorial_convenience_method, number_of_diagram_arguments, limit, output_path;
    
    output_string =
"""# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
# THIS FILE IS AUTOMATICALLY GENERATED, SEE LimitConvenience.gi
""";
    
    #### helper functions
    generate_universal_morphism_convenience = function( limit, universal_morphism_name, object_name, diagram_position )
      local current_string, test_object_position, diagram_filter_list_string, tau_filter, list_selector;
        
        if (@not diagram_position in [ "Source", "Range" ])
            
            Error( "diagram_position must be \"Source\" or \"Range\"" );
            
        end;
        
        if (limit.number_of_unbound_morphisms == 0)
            
            # diagram can be derived from morphism(s) via diagram_position
            
            if (limit.number_of_targets == 1)
                
                Error( "this case is currently not supported" );
                
            elseif (limit.number_of_targets > 1)
                
                # derive diagram from morphisms via diagram_position
                current_string = @Concatenation(
                    "\n",
                    "##\n",
                    "InstallMethod( ", universal_morphism_name, ",\n",
                    "               [ IsList ],\n",
                    "               \n",
                    "  function( list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( CapCategory( list[1] ), list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategory, IsList ],\n",
                    "               \n",
                    "  function( cat, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( cat, List( list, ", diagram_position, " ), list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategoryObject, IsList ],\n",
                    "               \n",
                    "  function( test_object, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( CapCategory( test_object ), test_object, list );\n",
                    "    \n",
                    "end );\n",
                    "\n",
                    "##\n",
                    "InstallOtherMethod( ", universal_morphism_name, ",\n",
                    "               [ IsCapCategory, IsCapCategoryObject, IsList ],\n",
                    "               \n",
                    "  function( cat, test_object, list )\n",
                    "    #% CAP_JIT_RESOLVE_FUNCTION\n",
                    "    \n",
                    "    return ", universal_morphism_name, "( cat, List( list, ", diagram_position, " ), test_object, list );\n",
                    "    \n",
                    "end );\n"
                );
                
                output_string = @Concatenation( output_string, current_string );
                
            end;
            
        end;
        
        # derive test object
        if (IsOperation( ValueGlobal( universal_morphism_name ) ))
            
            if (diagram_position == "Source")
                
                test_object_position = "Range";
                
            elseif (diagram_position == "Range")
                
                test_object_position = "Source";
                
            else
                
                Error( "this should never happen" );
                
            end;
            
            if (limit.number_of_targets == 1)
                
                tau_filter = "IsCapCategoryMorphism";
                list_selector = "";
                
            else
                
                tau_filter = "IsList";
                list_selector = "[1]";
                
            end;
            
            current_string = ReplacedStringViaRecord( """
@InstallMethod( without_given_universal_morphism,
                    [ diagram_filter_list..., tau_filter ],
                    
    function( diagram_arguments..., tau )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return without_given_universal_morphism( diagram_arguments..., test_object_position( selected_tau ), tau );
        
end );

@InstallMethod( without_given_universal_morphism,
                    [ IsCapCategory, diagram_filter_list..., tau_filter ],
                    
    function( cat, diagram_arguments..., tau )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return without_given_universal_morphism( cat, diagram_arguments..., test_object_position( selected_tau ), tau );
        
end );

@InstallMethod( with_given_universal_morphism,
                    [ diagram_filter_list..., tau_filter, IsCapCategoryObject ],
                    
    function( diagram_arguments..., tau, P )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return with_given_universal_morphism( diagram_arguments..., test_object_position( selected_tau ), tau, P );
        
end );

@InstallMethod( with_given_universal_morphism,
                    [ IsCapCategory, diagram_filter_list..., tau_filter, IsCapCategoryObject ],
                    
    function( cat, diagram_arguments..., tau, P )
        #% CAP_JIT_RESOLVE_FUNCTION
        
        return with_given_universal_morphism( cat, diagram_arguments..., test_object_position( selected_tau ), tau, P );
        
end );
""",
                @rec(
                    without_given_universal_morphism = universal_morphism_name,
                    with_given_universal_morphism = @Concatenation( universal_morphism_name, "WithGiven", object_name ),
                    diagram_filter_list = List( CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( limit.diagram_filter_list ), NameFunction ),
                    tau_filter = tau_filter,
                    diagram_arguments = limit.diagram_arguments_names,
                    test_object_position = test_object_position,
                    selected_tau = @Concatenation( "tau", list_selector ),
                )
            );
            
            output_string = @Concatenation( output_string, current_string );

        end;
        
    end;
    
    generate_functorial_convenience_method = function( limit, limit_colimit, object_name, functorial_name, functorial_with_given_name )
      local functorial_with_given_record, filter_list, arguments_names, arguments_string, source_diagram_arguments_string, range_diagram_arguments_string, replaced_filter_list, current_string, input_arguments_names, source_argument_name, range_argument_name, source_diagram_arguments_names, range_diagram_arguments_names, equalizer_preprocessing, test_string, additional_preconditions, test_arguments, universal_morphism_with_given_name, call_arguments;
        
        @Assert( 0, limit_colimit in [ "limit", "colimit" ] );
        
        functorial_with_given_record = method_name_record[limit.limit_functorial_with_given_name];
        
        if (Length( limit.diagram_filter_list ) > 0 && limit.number_of_unbound_morphisms == 0 && (limit.limit_object_name != limit.colimit_object_name || limit_colimit == "limit"))
            
            # convenience: derive diagrams from arguments
            filter_list = limit.diagram_morphism_filter_list;
            arguments_names = limit.diagram_morphism_arguments_names;
            
            @Assert( 0, Length( filter_list ) == 1 );
            @Assert( 0, Length( arguments_names ) == 1 );
            
            arguments_string = JoinStringsWithSeparator( arguments_names, ", " );
            
            if (limit.number_of_targets == 1)
                source_diagram_arguments_string = @Concatenation( "Source( ", arguments_string, " )" );
                range_diagram_arguments_string = @Concatenation( "Range( ", arguments_string, " )" );
            else
                source_diagram_arguments_string = @Concatenation( "List( ", arguments_string, ", Source )" );
                range_diagram_arguments_string = @Concatenation( "List( ", arguments_string, ", Range )" );
            end;
            
            replaced_filter_list = List( CAP_INTERNAL_REPLACED_STRINGS_WITH_FILTERS( filter_list ), NameFunction );
            
            current_string = ReplacedStringViaRecord( """
##
@InstallMethod( functorial_name,
                    [ filter_list... ],
               
  function( input_arguments... )
    
    return functorial_name( source_diagram_arguments, input_arguments..., range_diagram_arguments );
    
end );
""",
                @rec(
                    functorial_name = functorial_name,
                    filter_list = replaced_filter_list,
                    input_arguments = arguments_names,
                    source_diagram_arguments = source_diagram_arguments_string,
                    range_diagram_arguments = range_diagram_arguments_string,
                )
            );
            
            output_string = @Concatenation( output_string, current_string );
            
            # it is safe to use InstallOtherMethodForCompilerForCAP because there is no other two-argument convenience method for functorials
            current_string = ReplacedStringViaRecord( """
##
@InstallMethod( functorial_name,
                                     [ IsCapCategory, filter_list... ],
                    
  function( cat, input_arguments... )
    
    return functorial_name( cat, source_diagram_arguments, input_arguments..., range_diagram_arguments );
    
end );
""",
                @rec(
                    functorial_name = functorial_name,
                    filter_list = replaced_filter_list,
                    input_arguments = arguments_names,
                    source_diagram_arguments = source_diagram_arguments_string,
                    range_diagram_arguments = range_diagram_arguments_string,
                )
            );
            
            output_string = @Concatenation( output_string, current_string );
            
            current_string = ReplacedStringViaRecord( """
##
@InstallMethod( functorial_with_given_name,
               [ IsCapCategoryObject, filter_list..., IsCapCategoryObject ],
               
  function( source, input_arguments..., range )
    
    return functorial_with_given_name( source, source_diagram_arguments, input_arguments..., range_diagram_arguments, range );
    
end );
""",
                @rec(
                    functorial_with_given_name = functorial_with_given_name,
                    filter_list = replaced_filter_list,
                    input_arguments = arguments_names,
                    source_diagram_arguments = source_diagram_arguments_string,
                    range_diagram_arguments = range_diagram_arguments_string,
                )
            );
            
            output_string = @Concatenation( output_string, current_string );
            
            # it is safe to use InstallOtherMethodForCompilerForCAP because there is no other four-argument convenience method for with given functorials
            current_string = ReplacedStringViaRecord( """
##
@InstallMethod( functorial_with_given_name,
                                     [ IsCapCategory, IsCapCategoryObject, filter_list..., IsCapCategoryObject ],
               
  function( cat, source, input_arguments..., range )
    
    return functorial_with_given_name( cat, source, source_diagram_arguments, input_arguments..., range_diagram_arguments, range );
    
end );
""",
                @rec(
                    functorial_with_given_name = functorial_with_given_name,
                    filter_list = replaced_filter_list,
                    input_arguments = arguments_names,
                    source_diagram_arguments = source_diagram_arguments_string,
                    range_diagram_arguments = range_diagram_arguments_string,
                )
            );
            
            output_string = @Concatenation( output_string, current_string );
            
        end;
        
        # derive functorials from the universality of the limit
        # only do this for limits, colimits will be handled by the automatic dualization of derivations
        if (limit_colimit == "limit")
            
            @Assert( 0, Length( limit.diagram_morphism_filter_list ) <= 1 );
            @Assert( 0, Length( limit.diagram_morphism_arguments_names ) <= 1 );
            
            input_arguments_names = functorial_with_given_record.input_arguments_names;
            
            source_argument_name = input_arguments_names[2];
            range_argument_name = Last( input_arguments_names );
            
            source_diagram_arguments_names = limit.functorial_source_diagram_arguments_names;
            range_diagram_arguments_names = limit.functorial_range_diagram_arguments_names;
            
            # EqualizerFunctorialWithGivenEqualizers would have 8 arguments if the source objects would be given
            # -> we have to work around this and derive the source objects from the morphism between the diagrams.
            equalizer_preprocessing = "";
            
            if (Length( limit.diagram_filter_list ) > 0)
                
                if (limit.number_of_targets == 1)
                    
                    @Assert( 0, limit.diagram_morphism_arguments_names == [ "mu" ] );
                    
                    test_string = ReplacedStringViaRecord(
                        "PreCompose( cat, projection_with_given( cat, source_diagram..., source_object ), mu )",
                        @rec(
                            projection_with_given = limit.limit_projection_with_given_name,
                            source_diagram = source_diagram_arguments_names,
                            source_object = source_argument_name,
                        )
                    );
                    
                    additional_preconditions = [ "[ PreCompose, 1 ]", @Concatenation( "[ ", limit.limit_projection_with_given_name, ", 1 ]" ) ];
                        
                    if (limit.number_of_unbound_morphisms > 1)
                        
                        if (limit.limit_object_name != "Equalizer")
                            
                            Error( "This is a hack which might not be valid in general." );
                            
                        end;
                        
                        # we are in the Equalizer case, which needs special handling (see above)
                        equalizer_preprocessing = "local Y, Yp;\n    \n    Y = Source( mu );\n    Yp = Range( mu );\n    ";
                        
                    end;
                    
                else
                    
                    @Assert( 0, limit.diagram_morphism_arguments_names == [ "L" ] );
                    
                    test_string = ReplacedStringViaRecord(
                        "List( (1):(Length( L )), i -> PreCompose( cat, projection_with_given( cat, source_diagram..., i, source_object ), L[i] ) )",
                        @rec(
                            projection_with_given = limit.limit_projection_with_given_name,
                            source_diagram = source_diagram_arguments_names,
                            source_object = source_argument_name,
                        )
                    );
                    
                    additional_preconditions = [ "[ PreCompose, 2 ]", @Concatenation( "[ ", limit.limit_projection_with_given_name, ", 2 ]" ) ];
                    
                end;
                
                test_arguments = [ test_string ];
                
            else
                
                @Assert( 0, limit.diagram_morphism_arguments_names == [ ] );
                
                test_arguments = [ ];
                
                additional_preconditions = [ ];
                
            end;
            
            universal_morphism_with_given_name = limit.limit_universal_morphism_with_given_name;
            call_arguments = @Concatenation( [ "cat" ], range_diagram_arguments_names, [ source_argument_name ], test_arguments, [ range_argument_name ] );
            
            current_string = ReplacedStringViaRecord( """
##
AddDerivationToCAP( functorial_with_given_name,
                    "functorial_with_given_name using the universality of the limit_colimit",
                    [ preconditions... ],
                    
  function( input_arguments... )
    equalizer_preprocessing
    return universal_morphism_with_given( call_arguments... );
    
end );
""",
                @rec(
                    functorial_with_given_name = functorial_with_given_name,
                    input_arguments = input_arguments_names,
                    preconditions = @Concatenation( [ @Concatenation( "[", universal_morphism_with_given_name, ", 1 ]" ) ], additional_preconditions ),
                    equalizer_preprocessing = equalizer_preprocessing,
                    universal_morphism_with_given = universal_morphism_with_given_name,
                    call_arguments = call_arguments,
                    limit_colimit = limit_colimit,
                )
            );
            
            output_string = @Concatenation( output_string, current_string );
            
            # derive functorial of empty limits from IdentityMorphism
            if (Length( limit.diagram_filter_list ) == 0)
                
                current_string = ReplacedStringViaRecord( """
##
AddDerivationToCAP( functorial_name,
                    "functorial_name by taking the identity morphism of object_name",
                    [ [ object_name, 1 ],
                      [ IdentityMorphism, 1 ] ],
                    
  function( cat )
    
    return IdentityMorphism( cat, object_name( cat ) );
    
end );
""",
                    @rec(
                        functorial_name = functorial_name,
                        object_name = object_name,
                    )
                );
                
                output_string = @Concatenation( output_string, current_string );
                
            end;
            
        end;
        
    end;
    
    for limit in limits
        
        number_of_diagram_arguments = Length( limit.diagram_filter_list );
        
        if (number_of_diagram_arguments > 0)
            
            #### universal morphism convenience
            generate_universal_morphism_convenience( limit, limit.limit_universal_morphism_name, limit.limit_object_name, "Range" );
            generate_universal_morphism_convenience( limit, limit.colimit_universal_morphism_name, limit.colimit_object_name, "Source" );
            
        end;
        
        #### functorial convenience method
        generate_functorial_convenience_method( limit, "limit", limit.limit_object_name, limit.limit_functorial_name, limit.limit_functorial_with_given_name );
        generate_functorial_convenience_method( limit, "colimit", limit.colimit_object_name, limit.colimit_functorial_name, limit.colimit_functorial_with_given_name );
        
    end;
    
    if (!(IsExistingFileInPackageForHomalg( package_name, "LimitConvenienceOutput.gi" )) || output_string != ReadFileFromPackageForHomalg( package_name, "LimitConvenienceOutput.gi" ))
        
        output_path = Filename( DirectoryTemporary( ), "LimitConvenienceOutput.gi" );
        
        WriteFileForHomalg( output_path, output_string );
        
        Display( @Concatenation(
            "WARNING: The file LimitConvenienceOutput.gi differs from the automatically generated one. ",
            "You can view the automatically generated file at the following path: ",
            output_path
        ) );
        
    end;
    
end );
